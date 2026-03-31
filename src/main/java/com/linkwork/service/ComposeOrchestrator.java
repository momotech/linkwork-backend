package com.linkwork.service;

import com.linkwork.model.dto.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * Docker Compose 模式编排器 — ALONE 模式桩实现
 * 后续阶段补充完整的 docker-java 容器管理逻辑
 */
@Service
@ConditionalOnProperty(name = "linkwork.agent.sandbox.provider", havingValue = "compose")
@Slf4j
public class ComposeOrchestrator implements K8sOrchestrator {

    @Override
    public ServiceBuildResult buildService(MergedConfig config) {
        log.warn("ComposeOrchestrator.buildService not yet implemented");
        return ServiceBuildResult.builder()
                .serviceId(config.getServiceId())
                .success(false)
                .errorMessage("Compose orchestrator not yet implemented")
                .build();
    }

    @Override
    public ServiceStatusResponse getServiceStatus(String serviceId) {
        return ServiceStatusResponse.builder()
                .serviceId(serviceId)
                .build();
    }

    @Override
    public StopResult stopService(String serviceId, boolean graceful) {
        log.warn("ComposeOrchestrator.stopService not yet implemented for {}", serviceId);
        return StopResult.builder()
                .serviceId(serviceId)
                .success(false)
                .errorMessage("Compose orchestrator not yet implemented")
                .build();
    }

    @Override
    public void cleanupService(String serviceId) {
        log.warn("ComposeOrchestrator.cleanupService not yet implemented for {}", serviceId);
    }

    @Override
    public GeneratedSpec previewSpec(MergedConfig config) {
        return null;
    }

    @Override
    public ScaleResult scaleDown(String serviceId, String podName) {
        return ScaleResult.failed(serviceId, "Scale not supported in Compose mode");
    }

    @Override
    public ScaleResult scaleUp(String serviceId, int targetPodCount, MergedConfig config) {
        return ScaleResult.failed(serviceId, "Scale not supported in Compose mode");
    }

    @Override
    public List<String> getRunningPods(String serviceId) {
        return Collections.emptyList();
    }

    @Override
    public List<String> listAllServiceIds() {
        return Collections.emptyList();
    }
}
