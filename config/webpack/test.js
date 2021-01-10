// eslint-disable-next-line no-undef
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

import { toWebpackConfig } from './environment';

// eslint-disable-next-line no-undef
export default toWebpackConfig();
