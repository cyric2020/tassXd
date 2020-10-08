/*****************************************************************************
	(C) Copyright The Alpha School System Pty Ltd 2015 All Rights Reserved
******************************************************************************/
(function (root, factory) {
	if(typeof define === "function" && define.amd) {
		define('captcha'+(window.curl?'.js':''),['jquery','fiber'+(window.curl?'.js':'')], function(jquery,fiber){
			return factory(jquery,fiber);
		});
	} else if(typeof module === "object" && module.exports) {
    	module.exports = factory(require("jquery"),require('fiber'));
	} else {
		root.captcha = factory(jQuery,_fiber);
	}
}(this, function($,fiber) {
	"use strict";

/*****************************************************************************
	(C) Copyright The Alpha School System Pty Ltd 2017 All Rights Reserved
******************************************************************************/
(function ($,f) { // eslint-disable-line

	$.widget("ui.captcha", {

		options: {
			"type": "cfcaptcha",
			"imageurl": null,
			"sitekey": null
		},

		_create : function(){

			var self = this, options = self.options;

		},

		_googleRecatchaInit : function(){

			var self = this, recaptcha;

			recaptcha = self.element.closest(".recaptcha-wrapper");
			
			if ( recaptcha.length < 1 ) {
				recaptcha = self.element.siblings(".recaptcha-wrapper");
			}

			recaptcha = recaptcha.find(".recaptcha");

			grecaptcha.render(recaptcha[0], {
				"sitekey" : self.options.sitekey,
				"callback" : self._googleRecatchaCallback.bind(self)
			});

		},

		_googleRecatchaCallback : function(response){

			var self = this;

			self.element.val(response);

		},

		"load" : function(data) {

			var self = this, captchahtml = '', controlgroup, api;

			if ( data.type === 'cfcaptcha' && data.imageurl ) {

				if ( !self.templatecreated ) {

					self.element.removeClass("include-hidden");

					self.templatecreated = true;

					captchahtml += '<div class="control-group captcha-control-group">';
					captchahtml += '<label id="captcha_label" for="captcha" class="control-label required">';
					captchahtml += '<span class="required bg-sprite"></span>';
					captchahtml += 'Security Code';
					captchahtml += '</label>';
					captchahtml += '<div class="controls controls-row captcha-controls">';
					captchahtml += '<div class="help-block" style="display: block;">';
					captchahtml += 'Enter the text below to<br />confirm your login credentials.';
					captchahtml += '</div>';
					captchahtml += '<div class="field-wrap" style="margin-top: 4px; height: 50px;">';
					captchahtml += '<img class="captcha-image" src="'+data.imageurl+'" border="0" />';
					captchahtml += '</div>';
					captchahtml += '<div class="help-block" style="display: block;">';
					captchahtml += 'Having Trouble? <button id="refresh-captcha" type="button" data-event="validate" class="btn btn-text href refresh-captcha">Click to Refresh</button>';
					captchahtml += '</div>';
					captchahtml += '</div>';
					captchahtml += '</div>';

					self.element.after(captchahtml);

				}

				controlgroup = self.element.closest(".captcha-control-group");
				
				if ( controlgroup.length < 1 ) {
					controlgroup = self.element.siblings(".captcha-control-group");
					controlgroup.find(".captcha-controls").prepend(self.element);
				}

				controlgroup.find(".captcha-image").attr('src', data.imageurl);
				
			} else if ( data.type === 'recaptcha' ) {

				if ( !self.templatecreated ) {

					self.templatecreated = true;

					self._setOption('sitekey',data.sitekey);

					window.googleRecatchaInit = self._googleRecatchaInit.bind(self);

					captchahtml += '<div class="recaptcha-wrapper"></div>';

					self.element.attr('data-fiber-validation_parent', '.recaptcha-wrapper');
					
					self.element.wrap($(captchahtml));
					self.element.after('<div class="recaptcha"></div>');

					api = document.createElement('script');
					api.setAttribute('src','https://www.google.com/recaptcha/api.js?onload=googleRecatchaInit&render=explicit');
					
					document.head.appendChild(api);

				}

				try {
					grecaptcha.reset();
				} catch(err){
					
				}

			}

		}

	});

}(jQuery,_fiber));
})); 