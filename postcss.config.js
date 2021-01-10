// eslint-disable-next-line no-undef
module.exports = {
  plugins: [
    // eslint-disable-next-line no-undef
    require('postcss-import'),
    // eslint-disable-next-line no-undef
    require('postcss-flexbugs-fixes'),
    // eslint-disable-next-line no-undef
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
};
