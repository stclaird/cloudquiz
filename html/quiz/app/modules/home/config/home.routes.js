(function() {

    'use strict';

    /**
     * @ngdoc object
     * @name app.home.config:homeRoutes
     * @description The config block for 'app.home' to hold all routes related to the home module
     **/
    angular
        .module('app.home')
        .config(homeRoutes);

    homeRoutes.$inject = ['$stateProvider', '$urlRouterProvider'];

    function homeRoutes($stateProvider, $urlRouterProvider) {

        var homeMain = {
            name: 'home',
            url: '/',
            abstract: true,
            templateUrl: 'app/modules/home/views/home-core.html'
        };

        var homeDefault = {
            name: 'home.default',
            url: 'home',
            parent: 'home',
            controller: 'HomeController',
            controllerAs: 'vm',
            templateUrl: 'app/modules/home/views/home.html'
        };

        var homeQuizMain = {
            name: 'home.quiz',
            url: 'quiz',
            parent: homeMain,
            abstract: true,
            template: '<ui-view></ui-view>'
        };

        var homeQuizSelect = {
            name: 'home.quiz.select',
            url: '/select',
            parent: homeQuizMain,
            controller: 'QuizOptionsController',
            controllerAs: 'vm',
            templateUrl: 'app/modules/home/views/quiz-options.html'
        };

        var homeQuizQuestions = {
            name: 'home.quiz.questions',
            url: '/{topic:string}/questions',
            parent: homeQuizMain,
            controller: 'QuizQuestionsController',
            controllerAs: 'vm',
            templateUrl: 'app/modules/home/views/quiz-questions.html'
        };

        $stateProvider
            .state(homeMain)
            .state(homeDefault)
            .state(homeQuizMain)
            .state(homeQuizSelect)
            .state(homeQuizQuestions);

        $urlRouterProvider.otherwise('/quiz/select');
    }

})();


