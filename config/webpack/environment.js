import { environment } from '@rails/webpacker';
import { VueLoaderPlugin } from 'vue-loader';
import vue from './loaders/vue';
import eslint from './loaders/eslint';
import aliasConfig from './alias';

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
environment.loaders.append('eslint', eslint);
environment.config.merge(aliasConfig);
export default environment;
