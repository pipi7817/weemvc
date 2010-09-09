/**
 * 默认文档类
 * ibio-develop
 * 2010-8-21 2:47
 */
import application.actions.StartupCommand;
import application.actions.LoadDataCommand;
import org.weemvc.as2.control.Controller;

//---------------------初始化
Controller.getInstance().addCommand(StartupCommand, StartupCommand);
Controller.getInstance().executeCommand(StartupCommand, this);

//flashvars 传递 JSON url
Controller.getInstance().executeCommand(LoadDataCommand, _level0.playList);