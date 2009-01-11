/*
* ibio-develop
* Thu May 29 16:57:33 2008
*/

import utils.CopyRight;
import application.actions.StartupCommand;
import application.actions.LoadDataCommand;
import org.weemvc.as2.control.Controller;

stop();

_quality = "BEST";
var CopyRight = new CopyRight(_root, "谋天互动", "http://www.mousky.com");
//---------------------舞台管理
Stage.scaleMode = "noScale";
Stage.align = "TL";

//---------------------初始化
Controller.getInstance().addCommand(StartupCommand.NAME, StartupCommand);
Controller.getInstance().executeCommand(StartupCommand.NAME, this);

//flashvars 传递 JSON url
if (_level0.playList != undefined) {
	Controller.getInstance().executeCommand(LoadDataCommand.NAME, {playList:_level0.playList});
}else {
	Controller.getInstance().executeCommand(LoadDataCommand.NAME, {playList:"stuff/playList.json"});
}