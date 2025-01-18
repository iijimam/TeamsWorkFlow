Class Test.Prod Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Test.Prod" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Test.TeamsWorkflowOp" Category="" ClassName="Test.TeamsWorkflowOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">prod-78.westus.logic.azure.com</Setting>
    <Setting Target="Adapter" Name="SSLConfig">webapi</Setting>
    <Setting Target="Adapter" Name="URL">/workflows/7c36e4c2ca6e492ebea5e8917e867ac7/triggers/manual/paths/invoke</Setting>
    <Setting Target="Adapter" Name="HTTPPort">443</Setting>
    <Setting Target="Adapter" Name="SSLCheckServerIdentity">0</Setting>
    <Setting Target="Host" Name="QueryParam"><![CDATA[api-version=2016-06-01&sp=/triggers/manual/run&sv=1.0&sig=62lZikh0gXzd1oXZSkRcXKnzNgKPz8R4wuMapXLg2f4]]></Setting>
    <Setting Target="Host" Name="ArchiveIO">0</Setting>
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Host" Name="token"></Setting>
    <Setting Target="Adapter" Name="ProxyHTTPS">0</Setting>
    <Setting Target="Adapter" Name="LocalInterface"></Setting>
  </Item>
  <Item Name="Test.RSSFeedService" Category="" ClassName="Test.RSSFeedService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="RSS">https://www.nhk.or.jp/rss/news/cat0.xml</Setting>
    <Setting Target="Adapter" Name="SSLConfig">webapi</Setting>
    <Setting Target="Host" Name="TargetConfigName">Test.RSSFeedCheckProcess</Setting>
    <Setting Target="Adapter" Name="CallInterval">60</Setting>
  </Item>
  <Item Name="Test.RSSFeedCheckProcess" Category="" ClassName="Test.RSSFeedCheckProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
