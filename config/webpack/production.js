// eslint-disable-next-line no-undef
process.env.NODE_ENV = process.env.NODE_ENV || 'production';

import { toWebpackConfig } from './environment';

export default toWebpackConfig();
