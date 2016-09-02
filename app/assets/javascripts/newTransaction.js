var NewTransaction = function () {

    return {
        
        initTransactions: function () {
	        $('#date').datepicker({
	            dateFormat: 'dd.mm.yy',
	            prevText: '<i class="icon-chevron-left"></i>',
	            nextText: '<i class="icon-chevron-right"></i>',
	        });
	        
	        // Validation
	        $("#sky-form1").validate({
	            // Rules for form validation
	            rules:
	            {
	                symbol:
	                {
	                    required: true
	                },
	                quantity:
	                {
	                    required: true,
	                    number: true
	                },
	                price:
	                {
	                    required: true,
	                    number: true
	                },
	                action:
	                {
	                    required: true
	                },
	            },
	                                
	            // Messages for form validation
	            messages:
	            {
	                symbol:
	                {
	                    required: 'Please enter a symbol'
	                },
	                quantity:
	                {
	                    required: 'Please enter how many shares were involved in this transaction',
	                    number: 'Please enter a number for the quantity'
	                },
	                price:
	                {
	                    required: 'Please enter the price at the time of this transaction'
	                    number: 'Please enter a number for the price'
	                },
	                action:
	                {
	                    required: 'Please select the action'
	                },
	            },

	            // Ajax form submition
	            submitHandler: function(form)
	            {
	                $(form).ajaxSubmit(
	                {
	                    beforeSend: function()
	                    {
	                        $('#sky-form1 button[type="submit"]').addClass('button-uploading').attr('disabled', true);
	                    },
	                uploadProgress: function(event, position, total, percentComplete)
	                {
	                    $("#sky-form1 .progress").text(percentComplete + '%');
	                },
	                    success: function()
	                    {
	                        $("#sky-form1").addClass('submited');
	                        $('#sky-form1 button[type="submit"]').removeClass('button-uploading').attr('disabled', false);
	                    }
	                });
	            },  
	            
	            // Do not change code below
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });
        }

    };

}();