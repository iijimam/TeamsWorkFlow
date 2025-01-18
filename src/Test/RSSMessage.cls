Class Test.RSSMessage Extends %Persistent
{

Property Title As %String(MAXLEN = 300);

Property PublishedDate As %TimeStamp;

Property URL As %String(MAXLEN = 300);

Index URLIndex On (URL, PublishedDate);


Storage Default
{
<Data name="RSSMessageDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Title</Value>
</Value>
<Value name="3">
<Value>PublishedDate</Value>
</Value>
<Value name="4">
<Value>URL</Value>
</Value>
</Data>
<DataLocation>^Test.RSSMessageD</DataLocation>
<DefaultData>RSSMessageDefaultData</DefaultData>
<IdLocation>^Test.RSSMessageD</IdLocation>
<IndexLocation>^Test.RSSMessageI</IndexLocation>
<StreamLocation>^Test.RSSMessageS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
