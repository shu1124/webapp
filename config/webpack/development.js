// eslint-disable-next-line no-undef
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

// eslint-disable-next-line no-undef
const environment = require('./environment');

// eslint-disable-next-line no-undef
module.exports = environment.toWebpackConfig();
