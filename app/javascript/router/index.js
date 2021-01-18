import Vue from 'vue';
import VueRouter from 'vue-router';
Vue.use(VueRouter);
import PageUserRegister from '@/pages/PageUserRegister';
import PageUserLogin from '@/pages/PageUserLogin';
import PageTimeline from '@/pages/PageTimeline';
import PageMicropostDetail from '@/pages/PageMicropostDetail';
import PageProfile from '@/pages/PageProfile';
import PageUsers from '@/pages/PageUsers';
import PageMicropostLike from '@/pages/PageMicropostLike';
import PageFollowList from '@/pages/PageFollowList';
import PageFollowerList from '@/pages/PageFollowerList';

const router = new VueRouter({
  routes: [
    { path: '/signup', component: PageUserRegister, name: 'user-register' },
    { path: '/login', component: PageUserLogin, name: 'user-login' },
    { path: '/', component: PageTimeline, name: 'timeline' },
    { path: '/microposts', component: PageTimeline },
    { path: '/microposts/:id', component: PageMicropostDetail, name: 'micropost-detail' },
    { path: '/users/:id', component: PageProfile, name: 'user-profile' },
    { path: '/profile', component: PageUsers, name: 'users' },
    { path: '/like', component: PageMicropostLike, name: 'micropost-like' },
    { path: '/follow', component: PageFollowList, name: 'follow' },
    { path: '/follower', component: PageFollowerList, name: 'follower' },
  ]
});

export default router;