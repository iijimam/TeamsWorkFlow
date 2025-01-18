Class Test.TeamsMsg Extends Ens.Request
{

/// Teamsに送信したいJSON文字を丸ごと送りたいとき
Property Text As %String(MAXLEN = "");

/// アダプティブカードのテンプレートに渡すメッセージ
Property Message As %String(MAXLEN = 500);

/// アダプティブカードのテンプレートに渡すタイトル
Property ActionTitle As %String(MAXLEN = 100);

/// アダプティブカードのテンプレートに渡すUrl
Property ActionUrl As %String(MAXLEN = 500);

Storage Default
{
<Data name="TeamsMsgDefaultData">
<Subscript>"TeamsMsg"</Subscript>
<Value name="1">
<Value>Text</Value>
</Value>
<Value name="2">
<Value>Message</Value>
</Value>
<Value name="3">
<Value>ActionTitle</Value>
</Value>
<Value name="4">
<Value>ActionUrl</Value>
</Value>
</Data>
<DefaultData>TeamsMsgDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
