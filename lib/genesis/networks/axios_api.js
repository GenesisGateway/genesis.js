// Generated by CoffeeScript 2.7.0
(function() {
  var AxiosApi, AxiosHeaders, BaseRequestApi, axios, https;

  axios = require('axios');

  https = require('https');

  BaseRequestApi = require('./base_request_api');

  ({AxiosHeaders} = require('axios'));

  /*
    Axios Network Adapter
  */
  AxiosApi = class AxiosApi extends BaseRequestApi {
    // Axios Adapter constructor
    constructor() {
      super();
      this.instance = axios.create();
    }

    // Provide Gateway response headers
    getResponseHeaders() {
      if (!(this.responseHeaders instanceof AxiosHeaders)) {
        return this.responseHeaders;
      }
      return this.responseHeaders.toJSON();
    }

    // Provide Gateway response Content-Type
    getResponseContentType() {
      if (!(this.responseHeaders instanceof AxiosHeaders)) {
        return '';
      }
      return this.responseHeaders.get('content-type').toLowerCase();
    }

    // Load the Network object from the gateway response
    initNetwork(networkObject) {
      this.responseBody = networkObject.data;
      this.responseHeaders = networkObject.headers;
      this.responseStatus = parseInt(networkObject.status);
      return this;
    }

    // Prepare Axios request configuration
    prepareConfig(requestOptions) {
      return this.networkConfig = Object.assign(this.defaultConfig(), requestOptions);
    }

    // Send the Request
    send(url, params) {
      return this.doRequest(this.instance, this.prepareRequestData(url, params));
    }

    // Default Axios request configuration
    defaultConfig() {
      return {
        httpsAgent: new https.Agent({
          rejectUnauthorized: true,
          maxVersion: "TLSv1.2",
          minVersion: "TLSv1.2"
        }),
        responseType: 'text',
        validateStatus: function(status) {
          return status >= 200 && status < 300;
        }
      };
    }

    // Prepare Axios request data
    prepareRequestData(url, params) {
      return Object.assign({
        url: url,
        data: params
      }, this.networkConfig);
    }

  };

  module.exports = AxiosApi;

}).call(this);
