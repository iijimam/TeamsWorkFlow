Class Test.AdaptiveCardActions Extends JSONTemplate.Base
{

Property ActionTitle As %String(MAXLEN = 100);

Property ActionUrl As %String(MAXLEN = 500);

XData Template [ MimeType = application/json ]
{
{
        "type": "Action.OpenUrl",
        "title": "#(..ActionTitle)#",
        "url": "#(..ActionUrl)#"
    }
}

}
