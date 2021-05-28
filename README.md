# FinalProject
畢製遊戲的程式碼

我給自己的小叮嚀

我有預感我會一直用到的指令
開新檔案：
d:
cd D:\MyProgram\HaxeFlixel
flixel tpl -n "NewProject" -ide vscode

Bruh為什麼一定要用Commend

如何把你偉大的遊戲丟到Github上
1. 把下面藍藍的地方改成html5
2. 按Ctrl+Shift+B
3. 去原檔案export\html5\bin，把裡面的東西全丟到Github資料夾裡
4. 更新你的Hithub，然後等一下(有點久，最好隔一陣子再看看，不可以沒耐性呦)
5. 好了！

html5支援中文，謝天謝地

所謂的extend(延伸)就是在原有的功能上再加上自己想要的功能。像是class MenuState extends FlxState就是在原有的FlxState上加料再叫它MenuState。

var player:Player;//定義這東西的樣式
player=new Player(20,20);//寫細部的東西
        add(player);//用力加進去

為什麼不能直接加速度移動角色，而要定義角度
當斜斜移動時，我們會期待斜斜移動的速度跟直線移動的速度一樣。如果今天想往左上移動，直接用上+左的速度─根據三角形定理─會跟直線移動的速度不一樣，所以需要定義角度，再加上速度。

速率：speed，沒方向
速度：velocity，有方向
所以往反方向等速跑步，speed一樣但velocity不同。

Flixel的座標
 
順時針轉加；逆時針轉減。

HaxeFlixel的座標是訂在左上角，但字會自動留邊邊。

HaxeFlixel輸出Html5時，只要是跑過的圖片，不管最後有沒有用上，都會存進資料夾裡（這解釋了為何FNF裡有些神秘的圖片）。而且如果替換的圖片名字一樣的話它是不會改的噢。
我找到辦法了！直接把圖輸出到image裡取代原本的圖（不可以從其他地方複製貼上）就可以更新圖片了！好樣的！
如果情況比較特殊的話直接把Html5的image資料夾清空也行。
