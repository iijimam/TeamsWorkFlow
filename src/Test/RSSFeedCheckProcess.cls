/// 
Class Test.RSSFeedCheckProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Test.RSSMessageBatch' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='removeIterator' type='%Integer' instantiate='0' />
<property name='Iterator' type='%Integer' instantiate='0' />
<property name='Message' type='Test.RSSMessage' instantiate='0' />
<property name='MessageBatch' type='Test.RSSMessageBatch' instantiate='0' />
<property name='MessageBatchInterator' type='%Integer' instantiate='0' />
<property name='chk' type='%Integer' instantiate='0' />
</context>
<sequence xend='200' yend='700' >
<foreach name='通知対象メッセージ作成' property='request.Messages' key='context.Iterator' xpos='200' ypos='250' xend='200' yend='900' >
<assign name="個々のメッセージ設定" property="context.Message" value="request.Messages.GetAt(context.Iterator)" action="set" languageOverride="" xpos='200' ypos='250' />
<sql name='通知対象かどうかチェック' xpos='200' ypos='350' >
<![CDATA[select count(id) into :context.chk from Test.RSSMessage
WHERE (URL=:context.Message.URL) AND (PublishedDate=:context.Message.PublishedDate)]]>
</sql>
<trace name='PublishedDateとURL' value='context.Iterator_": PublishedDate: "_context.Message.PublishedDate_" URL: "_context.Message.URL_" チェック結果："_context.chk' xpos='537' ypos='447' />
<if name='通知対象？' condition='context.chk&lt;2' xpos='200' ypos='450' xend='200' yend='800' >
<true>
<assign name="通し番号セット" property="context.MessageBatchInterator" value="context.MessageBatchInterator+1" action="set" languageOverride="" xpos='335' ypos='600' />
<assign name="通知対象設定" property="context.MessageBatch.Messages" value="context.Message" action="insert" languageOverride="" key="context.MessageBatchInterator" xpos='335' ypos='700' />
</true>
</if>
</foreach>
<if name='通知する？' condition='$ISOBJECT(context.MessageBatch)' xpos='200' ypos='350' xend='200' yend='600' >
<true>
<call name='Team通知' target='Test.TeamsWorkflowOp' async='0' xpos='470' ypos='500' >
<request type='Test.RSSMessageBatch' >
<assign property="callrequest" value="context.MessageBatch" action="set" languageOverride="" />
</request>
<response type='Ens.StreamContainer' />
</call>
</true>
<false>
<code name='通知なしのログ' xpos='200' ypos='500' >
<![CDATA[ $$$LOGINFO("通知対象メッセージなし")]]>
</code>
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
