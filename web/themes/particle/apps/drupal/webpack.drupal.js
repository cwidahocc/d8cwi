/**
 * Drupal-specific webpack config.
 */

const path = require('path');
const { DefinePlugin } = require('webpack');

// Plugins
// const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const RunScriptAfterEmit = require('../../tools/webpack/run-script-after-emit');

// Particle base settings
const particle = require('../../particle');

const shared = {
  entry: {
    'drupal-jquery': [path.resolve(__dirname, 'drupal-jquery.js')],
    'app-drupal': [path.resolve(__dirname, 'index.js')],
  },
  plugins: [
    new DefinePlugin({
      BUILD_TARGET: JSON.stringify('drupal'),
    }),
  ],
};

const dev = {
  stats: {
    children: false,
    entrypoints: false,
  },
  plugins: [
    new RunScriptAfterEmit({
      exec: [
        // prettier-ignore
        'drupal cr all',
      ],
    }),
  ],
};

const prod = {};

module.exports = particle(
  { shared, dev, prod },
  {
    cssMode: 'extract',
    entry: 'app-drupal',
  }
);
