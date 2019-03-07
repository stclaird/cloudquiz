(function() {

    'use strict';

    /**
     * @ngdoc controller
     * @name app.home.controllers:HomeController
     * @description The controller for the 'home' view
     * @requires ng.$http
     **/
    angular
        .module('app.home')
        .controller('HomeController', HomeController);

    HomeController.$inject = ['$http'];

    function HomeController($http) {

        var vm = this;
        vm.questionsUrl = '{api_URL}'; //add the API url 
        vm.requestParams = {
            'category': 'dynamodb'
        };
        vm.quizList = [];
        vm.topics = [
        {
            category: 'dynamodb',
            requestParams: 'dynamodb'
        }, {
            category: 'ec2',
            requestParams: 'ec2'
        },
        {
            category: 'sqs',
            requestParams: 'sqs'
        }
        ];

        vm.fetchQuestions = fetchQuestions;
        vm.setTopic = setTopic;

        vm.fetchQuestions();

        /**
         * @ngdoc function
         * @name app.home.controllers:HomeController#fetchQuestions
         * @methodOf app.home.controllers:HomeController
         * @description Makes the http.get request to fetch the questions and populates a success response in to
         * `vm.quizlList`
         * If `vm.activeTopic.category` is not set, the default category is set to dynamodb (See line 21)
         **/
        function fetchQuestions() {
            if (vm.activeTopic && vm.activeTopic.category) {
                vm.requestParams.category = vm.activeTopic.category;
            } else {
                vm.activeTopic = vm.topics[0];
                vm.fetchQuestions();
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

        /**
         * @ngdoc method
         * @name app.home.controllers:HomeController#setTopic
         * @methodOf app.home.controllers:HomeController
         * @description Sets a variable (`vm.activeTopic`) to contain the user selected topic as the main selected Topic
         * Call the `vm.fetchQuestions()` method to fetch new questions based on the selected category
         **/
        function setTopic(topic) {
            vm.activeTopic = topic;
            vm.fetchQuestions();
        }

    }

})();