use sysinfo::System;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    flutter_rust_bridge::setup_default_user_utils();
}

pub struct SystemStats {
    pub total_memory: u64,
    pub used_memory: u64,
    pub free_memory: u64,
    pub memory_usage_percent: f32,
    pub cpu_usage: f32,

    pub system_name: Option<String>,
    pub kernel_version: Option<String>,
    pub os_version: Option<String>,
    pub host_name: Option<String>,
    pub total_swap: u64,
    pub used_swap: u64,
}

pub fn get_system_stats() -> SystemStats {
    let mut sys = System::new_all();

    sys.refresh_memory();
    sys.refresh_cpu();

    let total = sys.total_memory();
    let used = sys.used_memory();
    let free = total - used;

    let cpu = sys.global_cpu_info().cpu_usage();

    SystemStats {
        total_memory: total,
        used_memory: used,
        free_memory: free,
        memory_usage_percent: (used as f32 / total as f32) * 100.0,
        cpu_usage: cpu,
        system_name: System::name(),
        kernel_version: System::kernel_version(),
        os_version: System::os_version(),
        host_name: System::host_name(),
        total_swap: sys.total_swap(),
        used_swap: sys.used_swap(),
    }
}
