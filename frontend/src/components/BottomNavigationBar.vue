<script setup lang="ts">
import { ref } from 'vue'
const active = ref(0)
</script>

<template>
  <van-tabbar v-model="active">
    <van-tabbar-item to="/genealogy" class="iconfont icon-jiazuzupu-">族谱</van-tabbar-item>
    <van-tabbar-item to="/mailbox" class="iconfont icon-xinxiang-xiankuang">信箱</van-tabbar-item>
    <van-tabbar-item to="/market" class="iconfont icon-gouwuche">集市</van-tabbar-item>
    <van-tabbar-item to="/my" class="iconfont icon-wodewo">我的</van-tabbar-item>
  </van-tabbar>
</template>

<style scoped></style>