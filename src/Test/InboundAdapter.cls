Class Test.InboundAdapter Extends Ens.InboundAdapter
{

Property RSS As %String;

Parameter SETTINGS = "RSS:接続設定";

/// default InboundAdapter behavior: always call ProcessInput on CallInterval
Method OnTask() As %Status
{
    set status=$$$OK
    try {
        #dim batchmessage As Test.RSSMessageBatch
        set batchmessage=..RSSParse(..RSS)
        $$$ThrowOnError(..BusinessHost.ProcessInput(batchmessage))
    }
    catch ex {
        set status=ex.AsStatus()
    }
    Set ..BusinessHost.%WaitForNextCallInterval=1
    return status
}

/// RSSをパース結果、entries以下のPython listを戻り値で返す
ClassMethod RSSParse(url As %String(MAXLEN=200)) As Test.RSSMessageBatch [ Language = python ]
{
import iris
import feedparser
import json
from datetime import datetime, timedelta, timezone
tz = timezone(timedelta(hours=+9), 'Asia/Tokyo')

rssfeed=feedparser.parse(url)

#サービスに送るメッセージクラスのインスタンス生成
batch=iris.cls("Test.RSSMessageBatch")._New()
#entries 以下にRSSの<channel>情報がlistで取得できる。
#published_parsedを使ってYYYY-MM-DD HH:MM:SSの形式に変換しておく(JSTで)
for data in rssfeed["entries"]:
    pubparsedate=data["published_parsed"]
    pubparsedateLocal=datetime(*pubparsedate[:6],tzinfo=timezone.utc).astimezone(tz)
    dispdate=pubparsedateLocal.strftime('%Y-%m-%d %H:%M:%S')

    #バッチクラスに含めるメッセージクラスのインスタンス生成
    msg=iris.cls("Test.RSSMessage")._New()
    msg.Title=data["title"]
    msg.PublishedDate=dispdate
    msg.URL=data["link"]
    #バッチクラスに登録
    batch.Messages.Insert(msg)
return batch
#list->JSON文字に変換して返す
#return json.dumps(newdata,ensure_ascii=False)
}

}
