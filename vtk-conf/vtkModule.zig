const std = @import("std");

//NOTE: This file is WIP

pub const ExportHeaderConfig = struct {
    library_target: []const u8, // Required parameter
    base_name: ?[]const u8 = null, // Optional, default null
    export_macro_name: ?[]const u8 = null, // Optional, default null
    no_export_macro_name: ?[]const u8 = null, // Optional, default null
    deprecated_macro_name: ?[]const u8 = null, // Optional, default null
    include_guard_name: ?[]const u8 = null, // Optional, default null
    static_define: ?[]const u8 = null, // Optional, default null
    no_deprecated_macro_name: ?[]const u8 = null, // Optional, default null
    define_no_deprecated: bool = false, // Optional, default false
    prefix_name: ?[]const u8 = null, // Optional, default null
    custom_content_from_variable: ?[]const u8 = null, // Optional, default null

    // Function to generate the header file content based on configuration
    pub fn generateHeader(self: *ExportHeaderConfig) ![]u8 {
        const allocator = std.heap.page_allocator;
        var header = std.ArrayList(u8).init(allocator);
        defer header.deinit();

        // Set up the basic structure
        const include_guard = self.include_guard_name orelse self.base_name orelse self.library_target;
        try header.appendSlice("#ifndef "[0..]);
        try header.appendSlice(include_guard);
        try header.appendSlice("_EXPORT_H\n#define ");
        try header.appendSlice(include_guard);
        try header.appendSlice("_EXPORT_H\n\n");

        // Check for static define
        if (self.static_define) |static_define| {
            try header.appendSlice("#ifdef ");
            try header.appendSlice(static_define);
            try header.appendSlice("\n#  define ");
            try header.appendSlice(self.export_macro_name orelse self.base_name orelse self.library_target);
            try header.appendSlice("\n#  define ");
            try header.appendSlice(self.no_export_macro_name orelse self.library_target);
            try header.appendSlice("_NO_EXPORT");
            try header.appendSlice("\n#else\n");
        } else {
            try header.appendSlice("#ifndef ");
            try header.appendSlice(self.export_macro_name orelse self.base_name orelse self.library_target);
            try header.appendSlice("_EXPORT");
            try header.appendSlice("\n#    ifdef ");
            try header.appendSlice(self.prefix_name orelse self.library_target);
            try header.appendSlice("_EXPORT\n");
            try header.appendSlice("        /* We are building this library */\n#      define ");
            try header.appendSlice(self.export_macro_name orelse "EXPORT_MACRO");
            try header.appendSlice(" __attribute__((visibility(\"default\")))\n");
            try header.appendSlice("#    else\n");
            try header.appendSlice("        /* We are using this library */\n#      define ");
            try header.appendSlice(self.export_macro_name orelse "EXPORT_MACRO");
            try header.appendSlice(" __attribute__((visibility(\"default\")))\n");
            try header.appendSlice("#    endif\n#endif\n");
        }

        // Handle the no-export macro
        try header.appendSlice("#  ifndef ");
        try header.appendSlice(self.no_export_macro_name orelse "NO_EXPORT");
        try header.appendSlice("\n#    define ");
        try header.appendSlice(self.no_export_macro_name orelse "NO_EXPORT");
        try header.appendSlice(" __attribute__((visibility(\"hidden\")))\n#  endif\n#endif\n\n");

        // Deprecated macro
        try header.appendSlice("#ifndef ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED");
        try header.appendSlice("\n#  define ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED");
        try header.appendSlice(" __attribute__((__deprecated__))\n#endif\n\n");

        // Deprecated export/no-export macros
        try header.appendSlice("#ifndef ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED_EXPORT");
        try header.appendSlice("\n#  define ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED_EXPORT");
        try header.appendSlice(" ");
        try header.appendSlice(self.export_macro_name orelse "EXPORT_MACRO");
        try header.appendSlice(" ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED");
        try header.appendSlice("\n#endif\n");

        try header.appendSlice("#ifndef ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED_NO_EXPORT");
        try header.appendSlice("\n#  define ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED_NO_EXPORT");
        try header.appendSlice(" ");
        try header.appendSlice(self.no_export_macro_name orelse "NO_EXPORT");
        try header.appendSlice(" ");
        try header.appendSlice(self.deprecated_macro_name orelse "DEPRECATED");
        try header.appendSlice("\n#endif\n");

        // Handle no-deprecated condition
        if (self.define_no_deprecated) {
            try header.appendSlice("\n#if 0 /* DEFINE_NO_DEPRECATED */\n");
            try header.appendSlice("#  ifndef ");
            try header.appendSlice(self.no_deprecated_macro_name orelse "NO_DEPRECATED");
            try header.appendSlice("\n#    define ");
            try header.appendSlice(self.no_deprecated_macro_name orelse "NO_DEPRECATED");
            try header.appendSlice("\n#  endif\n#endif\n\n");
        }

        // Custom content
        if (self.custom_content_from_variable) |custom_content| {
            try header.appendSlice(custom_content);
            try header.appendSlice("\n\n");
        }

        // End the include guard
        try header.appendSlice("#endif /* ");
        try header.appendSlice(include_guard);
        try header.appendSlice("_EXPORT_H */\n");

        return header.toOwnedSlice();
    }
};
