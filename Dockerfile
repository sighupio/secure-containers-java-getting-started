# Copyright 2020 SIGHUP s.r.l
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM reg.sighup.io/r/library/java/maven:3.6.3-openjdk-11 as builder

# Prepare directories
RUN mkdir /app
WORKDIR /app

# Copy the application
COPY pom.xml /app/pom.xml
COPY src /app/src

# Compile Java application
RUN mvn clean package

FROM reg.sighup.io/r/library/java/openjdk:11-jre

# Copy compiled app into /app directory
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo-0.0.1-SNAPSHOT.jar

# The app exposes 8080 port
EXPOSE 8080
