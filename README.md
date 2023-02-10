# Certified Images - Getting Started - Java (Maven and Spring Boot)

Welcome to the **Getting started** with Java applications using SIGHUP Certified images.
In this repository, you will find a simple hello world application written in Java.

The build process will use a maven certified image while it will run on top of OpenJDK.

## Requirements

Before continuing with this getting started, you will need:
- Valid subscription to the service.
  - Feel free to request access using [this simple google form](https://forms.gle/Wf916FGxUqRaLY5k7)
  - If you want extended support over the images, [consider to buy the subscription](https://gumroad.com/l/NiCYf).
- [`docker`](https://docs.docker.com/get-docker/)
  - `docker login reg.sihup.io` with your credentials before continuing.

## Build

Run the following commands from the root of this repository:

```bash
$ docker build -t spring-boot-maven:local .
# It will take 5-10 minutes
```

## Run

Everything is ready to run the java app:

```bash
$ docker run --name demo -d -p 8080:8080 -p 30000:30000 spring-boot-maven:local
d52b75b5d4495242a3c4a0bb3c6cb9e18eef7bd7e0fac3a003ec156bd9c5034b
$ docker logs demo
exec java -javaagent:/opt/SIGHUP/java/14/entrypoint/jmx_prometheus_javaagent.jar=30000:/opt/SIGHUP/java/14/configuration/jmx_exporter.yaml -XX:+ExitOnOutOfMemoryError -cp . -jar /app/demo-0.0.1-SNAPSHOT.jar
 _____  _____  _____  _   _  _   _ ______
/  ___||_   _||  __ \| | | || | | || ___ \
\ `--.   | |  | |  \/| |_| || | | || |_/ /
 `--. \  | |  | | __ |  _  || | | ||  __/
/\__/ / _| |_ | |_\ \| | | || |_| || |
\____/  \___/  \____/\_| |_/ \___/ \_|

2020-06-03 15:03:34.376  INFO 7 --- [           main] io.sighup.demo.DemoApplication           : Starting DemoApplication v0.0.1-SNAPSHOT on d52b75b5d449 with PID 7 (/app/demo-0.0.1-SNAPSHOT.jar started by root in /app)
2020-06-03 15:03:34.379  INFO 7 --- [           main] io.sighup.demo.DemoApplication           : No active profile set, falling back to default profiles: default
2020-06-03 15:03:35.857  INFO 7 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2020-06-03 15:03:35.869  INFO 7 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2020-06-03 15:03:35.870  INFO 7 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.35]
2020-06-03 15:03:35.957  INFO 7 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2020-06-03 15:03:35.957  INFO 7 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1521 ms
2020-06-03 15:03:36.295  INFO 7 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2020-06-03 15:03:36.792  INFO 7 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2020-06-03 15:03:36.815  INFO 7 --- [           main] io.sighup.demo.DemoApplication           : Started DemoApplication in 3.121 seconds (JVM running for 3.9)
```

Then the application is ready under 8080 port:

```bash
$ curl localhost:8080
Greetings from SIGHUP!
```

Prometheus JMX exporter is available in the 30000 port:

```bash
$ curl localhost:30000

<TRUNCATED OUTPUT>

# HELP jvm_threads_state Current count of threads by state
# TYPE jvm_threads_state gauge
jvm_threads_state{state="WAITING",} 12.0
jvm_threads_state{state="BLOCKED",} 0.0
jvm_threads_state{state="RUNNABLE",} 9.0
jvm_threads_state{state="TERMINATED",} 0.0
jvm_threads_state{state="TIMED_WAITING",} 4.0
jvm_threads_state{state="NEW",} 0.0
# HELP jvm_classes_loaded The number of classes that are currently loaded in the JVM
# TYPE jvm_classes_loaded gauge
jvm_classes_loaded 6616.0
# HELP jvm_classes_loaded_total The total number of classes that have been loaded since the JVM has started execution
# TYPE jvm_classes_loaded_total counter
jvm_classes_loaded_total 6616.0
# HELP jvm_classes_unloaded_total The total number of classes that have been unloaded since the JVM has started execution
# TYPE jvm_classes_unloaded_total counter
jvm_classes_unloaded_total 0.0
```

```bash
$ docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy --light spring-boot-maven:local
```
