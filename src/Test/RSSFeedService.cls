/// 
Class Test.RSSFeedService Extends Ens.BusinessService
{

Parameter ADAPTER = "Test.InboundAdapter";

Property TargetConfigName As %String;

/// 大量に情報がある場合の制限数を指定（デフォルトは空で無制限）
Property Limit As %Integer;

Parameter SETTINGS = "Limit:接続設定,TargetConfigName:接続設定:selector?context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

/// 第1引数に複数のメッセージのまとめて保持するメッセージクラスが渡る
/// 同じURLに対して新しい記事かどうかチェックする
/// Test.RSSMessageクラスに過去登録のあるPublishedDateか検索する
Method OnProcessInput(pInput As Test.RSSMessageBatch, pOutput As %RegisteredObject) As %Status
{
  //Adapterに設定したLimit数を超えてメッセージがある場合はメッセージカット
  if (..Limit'="")&(..Limit<pInput.Messages.Count()){
    for cn=1:1:pInput.Messages.Count() {
      if ..Limit<cn {
        do pInput.Messages.RemoveAt(cn)
      }
    }
  }
  
  set status=..SendRequestAsync(..TargetConfigName,pInput)
  return status
}

}
