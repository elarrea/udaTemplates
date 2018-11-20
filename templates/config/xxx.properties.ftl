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
 -- SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO, ni expresas ni implícitas.
 -- Véase la Licencia en el idioma concreto que rige los permisos y limitaciones
 -- que establece la Licencia.
 -->
<#if entornoEjie != "">
statics.path = http://desarrollo.jakina.ejiedes.net:7001/${codapp?lower_case}Statics
xlnets.path = https://xlnets.servicios.des.ejgv.euskalsarea.eus/n38a/N38LoginInicioServlet
#TRUE if it is portal embedded
xlnets.inPortal=FALSE 
<#else>
statics.path = /${codapp?lower_case}Statics
</#if>


#Loggin parameters
log.path=c:/datos/${codapp}/log
log.level.salidaEstandar=INFO
log.level.udaTrazas=TRACE
log.level.aplicTrazas=INFO
log.level.auditoriaAccesos=INFO

<#if entornoEjie != "">
# ========================================================
# PARAMETROS BIG DATA
# ========================================================

momo.servicio=uda
momo.app=${codapp}
momo.securityTokenId=PIB-3123456786-0

momo.w43taEndpointUri=data.intra.integracion.jakina.ejiedes.net
momo.w43taEndpointPort=80
momo.develomentMode=true
 
momo.doMomo.salidaEstandar=true
momo.doMomo.incidencias=true
momo.doMomo.udaTrazas=true
momo.doMomo.aplicTrazas=true
momo.doMomo.auditoriaAccesos=true
</#if>