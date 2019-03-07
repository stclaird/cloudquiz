(function() {

    'use strict';

    /**
     * @ngdoc controller
     * @name app.home.controllers:QuizOptionsController
     * @description Controller to display a list of topic options for quiz
     * @requires ng.$http
     **/
    angular
        .module('app.home')
        .controller('QuizOptionsController', QuizOptionsController);

    QuizOptionsController.$inject = ['$http'];

    function QuizOptionsController($http) {

        var vm = this;

        vm.topics = [{
                category: 'dynamodb',
                requestParams: 'dynamodb'
            }, {
                category: 'iam',
                requestParams: 'iam'
            },
            {
                category: 'sqs',
                requestParams: 'sqs'
            },
            {
                category: 'ec2',
                requestParams: 'ec2'
            },
            {
                category: 'sns',
                requestParams: 'sns'
            },
            {
                category: 's3',
                requestParams: 's3'
            },
            {
                category: 'cloudtrail',
                requestParams: 'cloutrail'
            }
        ];

    }

})();
