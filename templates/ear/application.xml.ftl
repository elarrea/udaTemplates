<?xml version="1.0" encoding="UTF-8"?>
<application xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xmlns:application="http://java.sun.com/xml/ns/javaee/application_5.xsd" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/application_5.xsd" id="Application_ID" version="5">
  <display-name>${codapp}EAR</display-name>
  <module>
    <web>
      <web-uri>${warName}.war</web-uri>
      <context-root>${warName}</context-root>
    </web>
  </module>
</application>