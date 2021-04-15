//Feito por Yume#0001
$(document).ready(function(){
	window.addEventListener("message",function(event){
		if ( event.data.css == "sucesso" ) {
			
			let html = " <div class='alert fade alert-simple alert-success alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show'><button type='button' class='close font__size-18' data-dismiss='alert'></button><i class='start-icon far fa-check-circle faa-tada animated'></i>"+event.data.mensagem+"</div>"
			$(html).appendTo("#notifications").hide().fadeIn(1000).delay(8000).fadeOut(1000);

		}
		else if (event.data.css == "importante" ){
			
			let html = "<div class='alert fade alert-simple alert-info alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show' role='alert' data-brk-library='component__alert'><i class='start-icon  fa fa-info-circle faa-shake animated'></i>"+event.data.mensagem+"</div>"
			$(html).appendTo("#notifications").hide().fadeIn(1000).delay(8000).fadeOut(1000);

		}
		else if ( event.data.css == "aviso") {

		
			let html = "<div class='alert fade alert-simple alert-warning alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show' role='alert' data-brk-library='component__alert'><i class='start-icon fa fa-exclamation-triangle faa-flash animated'></i>"+event.data.mensagem+"</div>"
			$(html).appendTo("#notifications").hide().fadeIn(1000).delay(8000).fadeOut(1000);

		}

		else if (event.data.css == "negado") {
			var html = "<div class='alert fade alert-simple alert-danger alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show' role='alert' data-brk-library='component__alert'><i class='start-icon far fa-times-circle faa-pulse animated'></i>"+event.data.mensagem+"</div>"
			$(html).appendTo("#notifications").hide().fadeIn(1000).delay(5000).fadeOut(1000);
		}

		else if (event.data.css == "bom" ) {
			var html = "<div class='alert fade alert-simple alert-primary alert-dismissible text-left font__family-montserrat font__size-16 font__weight-light brk-library-rendered rendered show' role='alert' data-brk-library='component__alert'><i class='start-icon fa fa-thumbs-up faa-bounce animated'></i>"+event.data.mensagem+"</div>"
			$(html).appendTo("#notifications").hide().fadeIn(1000).delay(5000).fadeOut(1000);
		}
	})
});

