<#-- 
 -- Copyright 2013 E.J.I.E., S.A.
 --
 -- Licencia con arreglo a la EUPL, Versión 1.1 exclusivamente (la «Licencia»);
 -- Solo podrá usarse esta obra si se respeta la Licencia.
 -- Puede obtenerse una copia de la Licencia en
 --
 --      http://ec.europa.eu/idabc/eupl.html
 --
 -- Salvo cuando lo exija la legislación aplicable o se acuerde por escrito, 
 -- el programa distribuido con arreglo a la Licencia se distribuye «TAL CUAL»,
 -- SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO, ni expresas ni implícitas.
 -- Véase la Licencia en el idioma concreto que rige los permisos y limitaciones
 -- que establece la Licencia.
 -->
 <beans xmlns="http://www.springframework.org/schema/beans"
 	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 	xmlns:p="http://www.springframework.org/schema/p"
 	xsi:schemaLocation="
  		http://www.springframework.org/schema/beans
  		http://www.springframework.org/schema/beans/spring-beans-3.2.xsd">	
 
 	<!-- UDA exporters -->
	<bean id="csvReport" class="com.ejie.x38.reports.CSVReportView" />
	<bean id="odsReport" class="com.ejie.x38.reports.ODSReportView" />
	<bean id="xlsReport" class="com.ejie.x38.reports.XLSReportView" />
	<bean id="xlsxReport" class="com.ejie.x38.reports.XLSXReportView" />

 	<!-- PDF (Jasper) 
  	<bean id="pdfUsuario" p:url="/WEB-INF/resources/reports/usuario.jasper"	
  			class="com.ejie.x38.reports.PDFReportView" />
  	-->
</beans>