/// https://kinoshita-hidetoshi.github.io/Programing-Items/Etc/Bash/send_message_to_teams_with_webhook.html
Class Test.TeamsWorkflowOp Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Property Adapter As EnsLib.HTTP.OutboundAdapter;

Parameter INVOCATION = "Queue";

Property JTemplate As %DynamicObject;

/// <a href="https://qiita.com/himarin269/items/3e521b3685e380605a44">https://qiita.com/himarin269/items/3e521b3685e380605a44</a><br>
/// 上記ページにクエリパラメータ指定時の注意有 %2Fを / に変更する
Property QueryParam As %String(MAXLEN = 500);

Parameter SETTINGS = "QueryParam:追加パラメータ";

Method SampleCall(pRequest As Test.RSSMessageBatch, Output pResponse As Ens.StreamContainer) As %Status
{
  set pResponse=##class(Ens.StreamContainer).%New()
  set card=##class(Test.AdaptiveCard).%New()
  set card.Message="最新情報到着！"

  for cn=1:1:pRequest.Messages.Count() {
    set actions=##class(Test.AdaptiveCardActions).%New()
    set msg=pRequest.Messages.GetAt(cn)
    set actions.ActionTitle=msg.Title
    set actions.ActionUrl=msg.URL
    do card.Actions.Insert(actions)
  }

  set status=card.OutputToDynamicObject(.json)
  set ..JTemplate=json
  $$$TRACE(..JTemplate.%ToJSON())
  
  set httprequest=##class(%Net.HttpRequest).%New()
  //ContentTypeの設定が必須の様子
  set httprequest.ContentType="application/json"
  set httprequest.ContentCharset="utf-8"
  do ..JTemplate.%ToJSON(httprequest.EntityBody)
  
  // QueryParameterの設定
  for cn=1:1:$length(..QueryParam,"&") {
    set name=$piece($piece(..QueryParam,"&",cn),"=",1)
    set val=$piece($piece(..QueryParam,"&",cn),"=",2)
    do httprequest.SetParam(name,val)
  }

  set status=..Adapter.SendFormDataArray(.pHttpResponse,"POST",httprequest)
  if $$$ISERR(status) {
    return status
  }

  if pHttpResponse.StatusCode'=200&(pHttpResponse.StatusCode'=202) {
    set errmessage=pHttpResponse.Data.Read()
    do pResponse.Stream.Write(errmessage)
    set status=$$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(status)_":"_errmessage) 
  }
  return status
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Test.RSSMessageBatch">
    <Method>SampleCall</Method>
  </MapItem>
</MapItems>
}

/// This user callback method is called via initConfig() from %OnNew() or in the case of SOAP Services from OnPreSOAP()
Method OnInit() As %Status
{
	Set compiledXdata=##class(%Dictionary.CompiledXData).%OpenId(..%ClassName(1)_"||Template")
  set tplstm=compiledXdata.Data
  do tplstm.Rewind()
  // JSONからオブジェクトを作成
  set tpl={}.%FromJSON(tplstm)
  set ..JTemplate=tpl
  return $$$OK
}

/// Description
XData Template [ MimeType = application/json ]
{
{
    "type":"message",
    "attachments":[
        {
            "contentType":"application/vnd.microsoft.card.adaptive",
            "contentUrl":null,
            "content": {
            "$schema":"http://adaptivecards.io/schemas/adaptive-card.json",
            "type":"AdaptiveCard",
            "version":"1.4",
            "body":[
                {
                    "type": "TextBlock",
                    "text":"テストメッセージです"
                }
            ]
        }
        }
    ]
}
}

}
