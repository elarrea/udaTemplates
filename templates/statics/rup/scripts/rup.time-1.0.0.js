//NO EDITAR

(function ($) {
	
	//****************************************************************************************************************
	// DEFINICIÓN BASE DEL PATRÓN (definición de la variable privada que contendrá los métodos y la función de jQuery)
	//****************************************************************************************************************
	
	var rup_time = {};
	
	//Se configura el arranque de UDA para que alberge el nuevo patrón 
	$.extend($.rup.iniRup, $.rup.rupSelectorObjectConstructor("rup_time", rup_time));
	
	//*******************************
	// DEFINICIÓN DE MÉTODOS PÚBLICOS
	//*******************************
	$.fn.rup_time("extend",{
		destroy : function(){
			//Eliminar máscara
			var labelMaskId = $(this).data("datepicker").settings.labelMaskId;
			if (labelMaskId){
				$("#"+labelMaskId).text("");
			}
			delete labelMaskId;
			//Eliminar imagen (reloj)
			$(this).next("img").remove();
			$(this).timepicker("destroy");
		},
		disable : function(){
		  $(this).timepicker("disable");
		},
		enable : function(){
		  $(this).timepicker("enable");
		},
		isDisabled : function(){
		  return $(this).timepicker("isDisabled");
		},
		hide : function(){
		  $(this).timepicker("hide");
		},
		show : function(){
		  $(this).timepicker("show");
		},
		getTime : function(){
			return $(this).val();
		},
		setTime : function(time){
		 	$(this).timepicker("refresh");//Necesario para 'inicializar' el componente
		 	$.datepicker._setTime($.datepicker._getInst($("#"+$(this).data("datepicker").settings.id)[0]), time);
		},
		refresh : function(){
	  		$(this).timepicker("refresh");
		},
		option : function(optionName, value){
	  		$(this).timepicker("option", optionName, value);
		}
		//No soportadas: widget, dialog
	});
	
	//*******************************
	// DEFINICIÓN DE MÉTODOS PRIVADOS
	//*******************************
	$.fn.rup_time("extend", {
			_init : function(args){
				if (args.length > 1) {
					$.rup.errorGestor($.rup.i18n.base.rup_global.initError + $(this).attr("id"));
				} else {
					//Se recogen y cruzan las paremetrizaciones del objeto
					var settings = $.extend({}, $.fn.rup_time.defaults, args[0]);

					//Se carga el identificador del padre del patron
					settings.id = $(this).attr("id");
					
					//Carga de propiedades/literales
					var literales = $.rup.i18n.base["rup_time"];
					for (var key in literales){
						$.timepicker._defaults[key] = literales[key];
					}
					
					//Mostrar máscara
					if (settings.labelMaskId){
						$("#"+settings.labelMaskId).text(literales.mask+" ");
					}
					
					//Imagen del reloj
					settings.buttonImage = $.rup.STATICS + (settings.buttonImage?settings.buttonImage:"/rup/basic-theme/images/clock.png");
					
					//Atributos NO MODIFICABLES
					
					//Timepicker
					$("#"+settings.id).timepicker(settings);
					
					//Max-Length
					//$("#"+settings.id).attr("maxlength",literales["mask"].length-2);
					
					//Añadir imagen 
					if (!$("#"+settings.id).is("div")){
						$("<img>").addClass("ui-timepicker-trigger")
							.attr({
								"src":settings.buttonImage,
								"alt":literales.buttonText,
								"title":literales.buttonText
							})
							.click(function(){
								if ( $("#ui-datepicker-div").css("display")==="none"){
									$("#"+settings.id).timepicker("show");
								} else { 
									$("#"+settings.id).timepicker("hide");
								} 
							})
							.insertAfter($("#"+settings.id));
					}
					
					//Deshabilitar
					if (settings.disabled){
						$("#"+settings.id).rup_time("disable");
					}
				}
			}
		});
		
	//******************************************************
	// DEFINICIÓN DE LA CONFIGURACION POR DEFECTO DEL PATRON  
	//******************************************************
	$.fn.rup_time.defaults = {
		stepHour: 1,
		stepMinute: 1,
		stepSecond: 1,
		showButtonPanel: false
	};	
	
	//Sobreescribir EVENTOS
	$.datepicker._timepicker_doKeyPress = $.datepicker._doKeyPress;
	$.datepicker._doKeyPress = function(event) {
		var instance = $.datepicker._get($.datepicker._getInst(event.target), 'timepicker');
		switch (event.keyCode) {
			//Izquierda
			case 37:if (event.ctrlKey && !(event.altKey || event.shiftKey)){ //Ctrl
							instance.hour_slider.slider("option", "value", instance.hour_slider.slider("option", "value")-instance._defaults.stepHour);
					 } else if (event.ctrlKey && event.shiftKey && !event.altKey){ //Ctrl + Shift
							instance.minute_slider.slider("option", "value", instance.minute_slider.slider("option", "value")-instance._defaults.stepMinute);
					 } else if (event.ctrlKey && event.shiftKey && event.altKey ){ //Ctrl + Shfit + Alt
							instance.second_slider.slider("option", "value", instance.second_slider.slider("option", "value")-instance._defaults.stepSecond);
					} 
					break;
			//Derecha
			case 39: if (event.ctrlKey && !(event.altKey || event.shiftKey)){ //Ctrl
							instance.hour_slider.slider("option", "value", instance.hour_slider.slider("option", "value")+instance._defaults.stepHour);
					 } else if (event.ctrlKey && event.shiftKey && !event.altKey){ //Ctrl + Shift
							instance.minute_slider.slider("option", "value", instance.minute_slider.slider("option", "value")+instance._defaults.stepMinute);
					 } else if (event.ctrlKey && event.shiftKey && event.altKey ){ //Ctrl + Shfit + Alt
							instance.second_slider.slider("option", "value", instance.second_slider.slider("option", "value")+instance._defaults.stepSecond);
					} 
					break;
		}
		if (instance){
		instance._onTimeChange();
		}
		return $.datepicker._timepicker_doKeyPress(event);
	};
	
})(jQuery);