# Official Tomcat 9 image with Java 11 (javax.servlet compatible).
FROM tomcat:9.0-jdk11-temurin

# Clean default apps. A tiny ROOT page redirects / to /attendance/.
RUN set -eux; \
    rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager; \
    mkdir -p /usr/local/tomcat/webapps/ROOT; \
    printf '%s\n' '<!doctype html><meta http-equiv="refresh" content="0;url=/attendance/"><a href="/attendance/">Open Attendance</a>' \
           > /usr/local/tomcat/webapps/ROOT/index.html

COPY attendance.war /usr/local/tomcat/webapps/attendance.war
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod +x /usr/local/tomcat/bin/entrypoint.sh

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]
