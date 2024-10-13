pub extern "js" fn log(msg : String) -> Unit =
  #| (msg) => { console.log(msg) }

pub extern "js" fn warn_log(msg : String) -> Unit =
  #| (msg) => { console.warn(msg) }

pub extern "js" fn error_log(msg : String) -> Unit =
  #| (msg) => { console.error(msg) }
