// eslint-disable-next-line no-undef
const path = require('path');
// eslint-disable-next-line no-undef
module.exports = {
  resolve: {
    alias: {
      // eslint-disable-next-line no-undef
      '@': path.resolve(__dirname, '..', '..', 'app/javascript')
    }
  }
};