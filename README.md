# questtextreader-addon

This addon generates links for the Quest Text Reader web app which reads quest texts out loud.
此插件为任务文本阅读器网络应用程序生成链接，该应用程序可以大声朗读任务文本。

*NOTE: The web app only works with Chrome and Safari at the moment! **
*注意：该网络应用程序目前仅适用于Chrome和Safari！**

How
Accept a quest (or type /qtr show)
接受任务（或键入 /qtr 显示）
A link encoding your quest log and character information will appear.
将出现一个编码您的任务日志和角色信息的链接。
Copy the link and open it in your browser.**
复制链接并在浏览器中打开它。
The web app will start reading the quests to you.
网络应用程序将开始向您朗读任务。
Accept other quests. 接受其他任务。
A new link will appear. 将出现一个新链接。
Copy the new link and paste it directly into the input field at the top of the web app.
复制新链接并将其直接粘贴到 Web 应用程序顶部的输入字段中。
The app will add the new quests to the play list.
该应用程序会将新任务添加到播放列表中。
Usage
/qtr on - Enable showing the link when you accept a new quest
/qtr on - 启用在接受新任务时显示链接
/qtr off - Disable showing the link when you accept a new quest
/qtr 关闭 - 接受新任务时禁用显示链接
/qtr show - Show the current link
/qtr 显示 - 显示当前链接
* The reason is that the web app uses the HTML5 Speech Synthesis API to generate the sound output. This API is currently only supported by Chrome and Safari. However, the API is a open standard and will eventually be available in other browsers as well.
* 原因是 Web 应用程序使用 HTML5 语音合成 API 来生成声音输出。此 API 目前仅受 Chrome 和 Safari 支持。但是，该API是一个开放标准，最终也将在其他浏览器中可用。

** The reason the link has to be copy-pasted manually is due to restrictions within the WoW programming environment, which does not allow direct communication with external sources. That being said, the addon and web app try to make the copy-paste process as seamless as possible.
** 链接必须手动复制粘贴的原因是由于 WoW 编程环境中的限制，不允许与外部源直接通信。话虽如此，插件和 Web 应用程序试图使复制粘贴过程尽可能无缝。
