# LocalLogger iOS
### This library can be used to collect, display, and share developer logs on client devices.

## Swift Package Manager (SPM)
> Add https://github.com/TetaLab-com/LocalLogger_iOS to your package dependencies.
The application stores logs and sessions in a local db data.

### Step 1: Import LocalLogger
To start using the library, you need to import it using
> import LocalLogger

### Step 2: Create new log sessions
It's required to create a session instance, so all logs will be linked to a specific session.
> LocalLogger.startSession()
#### This is a suspend function.

### Step 3: Add new logs.
There are a few types of logs that you can track:
> Info - used to track general information
> Warning - used to track developer warning
> Error - used to track error cases
> InMessage - used for messages received on Mobile phone
> OutMessage - used for messages sent from Mobile phone

**LocalLogger** - is a main class to collect and add logs.
It has several method calls to add logs into the system.

#### warning messages
You can also add optional **class name** and **method name** for additional debug purposes.
> LocalLogger.w(className: String, methodName: String, message: String)
> LocalLogger.w(message: String)

#### info messages
You can also add optional **class name** and **method name** for additional debug purposes.
> LocalLogger.i(className: String, methodName: String, message: String)
> LocalLogger.i(message: String)

#### warning messages
You can also add optional **class name** and **method name** for additional debug purposes.
> LocalLogger.w(className: String, methodName: String, message: String)
> LocalLogger.w(message: String)

#### error messages
You can also add optional **class name** and **method name** for additional debug purposes.
> LocalLogger.e(className: String, methodName: String, message: String)
> LocalLogger.e(message: String)

#### input messages
You can also add optional **class name** and **method name** for additional debug purposes.
> LocalLogger.inMessage(className: String, methodName: String, message: String)
> LocalLogger.inMessage(message: String)

#### output messages
You can also add optional **class name** and **method name** for additional debug purposes.
> LocalLogger.outMessage(className: String, methodName: String, message: String)
> LocalLogger.outMessage(message: String)

### Step 4: view collected messages
The library includes **LogsView** that can display collected messages for the active session, a list of previous sessions, and session details. The app can open it by executing the next command.

> LocalLogger.presentLogs()

The library also includes **CurrentLogsView**. It's a View that can display current session logs.

> LocalLogger.presentCurrentLogs()

### Conclusions

The library can be used to collect logs, help to understand issues on the user side, and provide access for the end user to view and share logs. 
