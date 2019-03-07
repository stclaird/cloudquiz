(function() {

    'use strict';

    /**
     * @ngdoc overview
     * @name app
     * @description The main app module
     */
    angular
        .module('app', [
            'ui.router',
            'ngAria',
            'ngMaterial',
            'ngMessages',
            'ngAnimate',
            'app.home'
        ]);

})();
