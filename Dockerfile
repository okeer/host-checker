FROM jboss/wildfly
COPY target/checker.war /opt/jboss/wildfly/standalone/deployments/