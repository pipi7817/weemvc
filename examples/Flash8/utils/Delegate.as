/*
* ibio-develop
* Wed Feb 27 11:13:18 2008
* Delegate 3.0
* 支持调用途中继续传递参数(和ASyncProcessor配合使用)
*/

class utils.Delegate extends Object {
	private var func:Function;
	
	function Delegate(f:Function) {
		func = f;
	} 
	
	static function create(obj:Object, func:Function, argument:Object):Function {
		var f = function () { 
			var target = arguments.callee.target;
			var func = arguments.callee.func;
			var arg = arguments.callee.arg;
			
			//如果传入参数为空，则保留原来状态
			if(arg == undefined){
				return func.apply(target, arguments);
			}else{
				return func.call(target, arg, arguments);
			}
			
		};
		
		f.target = obj;
		f.func = func;
		f.arg = argument;
		
		return f; 
	}
	
	function createDelegate(obj:Object, argument:Object):Function {
		return create(obj, func, argument);
	} 
}