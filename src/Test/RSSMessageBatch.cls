Class Test.RSSMessageBatch Extends Ens.Request
{

Property Messages As list Of Test.RSSMessage;

/// Description
Trigger DeleteRSSMessage [ Event = DELETE, Foreach = row/object ]
{
    new msgs,msgcn,msgid,st
    set msgs={Messages}
    for msgcn=1:1:$listlength(msgs) {
        set msgid=$LIST($list(msgs,msgcn),1)
        if ##class(Test.RSSMessage).%ExistsId(msgid) {
            set st=##class(Test.RSSMessage).%DeleteId(msgid)
            if $$$ISERR(st) {
                set %ok=0
                set SQLCODE=$system.Status.StatusToSQLCODE(st,.msg)
                set %msg=msg
            }
        }
    }
}

ClassMethod Test()
{
    set a1=##class(Test.RSSMessage).%New()
    set a1.Title="testtest"
    set a1.URL="http://localhost.com"
    set a1.PublishedDate="2024-12-12 01:22:33"
    set a2=##class(Test.RSSMessage).%New()
    set a2.Title="test2test2"
    set a2.URL="http://localhost2.com"
    set a2.PublishedDate="2024-10-12 11:12:33"   

    set msg=##class(Test.RSSMessageBatch).%New()
    do msg.Messages.Insert(a1)
    do msg.Messages.Insert(a2)
    w msg.%Save()
}

Storage Default
{
<Data name="RSSMessageBatchDefaultData">
<Subscript>"RSSMessageBatch"</Subscript>
<Value name="1">
<Value>Messages</Value>
</Value>
</Data>
<DefaultData>RSSMessageBatchDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
