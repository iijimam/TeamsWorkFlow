Class Test.AdaptiveCard Extends JSONTemplate.Base
{

Property Message As %String(MAXLEN = 500);

Property Actions As list Of Test.AdaptiveCardActions;

XData Template [ MimeType = application/json ]
{
{
    "type": "application/json",
    "attachments": [
        {
            "contentType": "object",
            "content": {
                "type": "AdaptiveCard",
                "version": "1.4",
                "msTeams": {
                    "width": "full"
                },
                "body": [
                    {
                        "type": "Image",
                        "url": "https://avatars.githubusercontent.com/u/67250170?s=200&v=4",
                        "altText": "コミュニティロゴ",
                        "width": "-7px",
                        "size": "Medium"
                    },
                    {
                        "type": "TextBlock",
                        "text": "RSS News!",
                        "wrap": true,
                        "fontType": "Default",
                        "size": "Large",
                        "weight": "Bolder",
                        "color": "Attention",
                        "isSubtle": true
                    },
                    {
                        "type": "TextBlock",
                        "text": "#(..Message)#",
                        "wrap": true
                    },
                    {
                        "type": "ActionSet",
                        "actions":["#(..Actions)#"]
                    }
                ]
            }
        }
    ]
}
}

}
