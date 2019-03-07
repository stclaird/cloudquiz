(function() {

    'use strict';

    /**
     * @ngdoc controller
     * @name app.home.controllers:QuizQuestionsController
     * @description Controller bound the view which displays questions based on the chosen topic
     * @requires ng.$http
     * @requires ui.router.$stateParams
     **/
    angular
        .module('app.home')
        .controller('QuizQuestionsController', QuizQuestionsController);

    QuizQuestionsController.$inject = ['$http', '$state', '$stateParams'];

    function QuizQuestionsController($http, $state, $stateParams) {

        var vm = this;
        vm.questionsUrl = '{api_url}'; //put api url here
        vm.requestParams = {
            'category': null
        };
        vm.topic = $stateParams.topic;

        vm.fetchQuestions = fetchQuestions;

        vm.fetchQuestions();

        /**
         * @ngdoc function
         * @name app.home.controllers:QuizQuestionsController#fetchQuestions
         * @methodOf app.home.controllers:QuizQuestionsController
         * @description Makes the http.get request to fetch the questions and populates a success response in to
         * `vm.quizlList`
         * If `vm.activeTopic.category` is not set, the default category is set to dynamodb (See line 21)
         **/
        function fetchQuestions() {
            if (!$stateParams.topic) {
                $state.go('home.quiz.select');
            } else {
                vm.requestParams.category = $stateParams.topic;
            }

            $http
                .get(vm.questionsUrl, {
                    'params': vm.requestParams
                })
                .then(function(success) {
                    vm.quizList = success.data;
                }, function(errors) {
                    console.log('Errors: ', errors);
                });
        }
    }

})();
