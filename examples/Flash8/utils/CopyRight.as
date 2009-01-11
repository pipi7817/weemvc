/**************************************************************************
 类   名: 右键版权
 作   用: 增加1个右键的版权
 方   法:
 CopyRight(target:MovieClip, menuName:String, menuURL:String)
 target:影响范围,通常为(_root)
 menuName:显示文本
 menuURL:点击此文本时转向的URL
 属   性：
***************************************************************************/

import utils.Delegate;
class utils.CopyRight extends MovieClip {
	public var myName = "Copyright";
	private var target;
	private var myMenu;
	private var menu1;
	private var menu2;
	private var menuName;
	private var menuURL;
	public function CopyRight(target:MovieClip, menuName:String, menuURL:String) {
		this.target = target;
		this.menuURL = menuURL;
		this.menuName = menuName;
		this.myMenu = new ContextMenu();
		this.myMenu.hideBuiltInItems();
		this.menu1 = new ContextMenuItem(this.menuName, Delegate.create(this, this._menu1_fun));
		//this.menu2 = new ContextMenuItem(time, menu2_fun);
		this.myMenu.customItems.push(menu1, menu2);
		this.target.menu = myMenu;
	}
	private function _menu1_fun() {
		this.target.getURL(this.menuURL, "_blank");
	}
}
