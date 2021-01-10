// eslint-disable-next-line no-undef
const { environment } = require('@rails/webpacker');
// eslint-disable-next-line no-undef
const { VueLoaderPlugin } = require('vue-loader');
// eslint-disable-next-line no-undef
const vue = require('./loaders/vue');
// eslint-disable-next-line no-undef
const aliasConfig = require('./alias');


environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
environment.config.merge(aliasConfig);
// eslint-disable-next-line no-undef
module.exports = environment;
