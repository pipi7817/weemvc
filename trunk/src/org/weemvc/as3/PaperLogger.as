/**
 * WeeMVC - Copyright(c) 2008-2009
 * 输出日志
 * @author	weemve.org
 * 2009-9-12 15:01
 */
package org.weemvc.as3 {
	import org.weemvc.as3.Version;
	import org.weemvc.as3.WeemvcError;
	
	public class PaperLogger {
		static private var m_instance:PaperLogger = null;
		//这里 logger 是静态类
		protected var m_traceLogger:Object;
		
		public function PaperLogger() {
			if (m_instance != null) {
				throw new WeemvcError(WeemvcError.SINGLETON_PAPERLOGGER_MSG, PaperLogger);
			}
			addLogger(Log);
		}
		
		static public function getInstance():PaperLogger {
			if (m_instance == null) {
				m_instance = new PaperLogger();
			}
			return m_instance;
		}
		
		public function addLogger(logger:Class):void {
			if (logger && (logger.record != null)) {
				m_traceLogger = logger;
			}
		}
		
		public function removeLogger():void {
			if (m_traceLogger) {
				m_traceLogger = null;
			}
		}
		
		public function log(errorMsg:String, currentClass:Class = null, ... rest):void {
			m_traceLogger.record(WeemvcError.formatMessage("WeeMVC Warning# ", errorMsg, currentClass, rest));
		}
	}
}

internal class Log {
	
	public static function record(msg:String):void {
		trace(msg);
	}
}