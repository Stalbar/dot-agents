# WordPress & SiteGround Standards (Local Rules)

## 1. Security & Data Integrity
- **Database Access**: Always use `$wpdb->prepare()` for custom SQL queries. Never concatenate or interpolate variables directly into SQL statements.
- **Nonce Verification**: Verify nonces on every state-changing POST/GET request or AJAX call using `check_admin_referer()` or `wp_verify_nonce()`.
- **Capability Checks**: Check user permissions explicitly with `current_user_can()` before executing privileged operations.
- **Sanitization & Late Escaping**:
  - Sanitize all input at the boundary: `sanitize_text_field()`, `sanitize_email()`, `absint()`, `wp_kses_post()`.
  - Escape all output at the point of rendering (late escaping): `esc_html()`, `esc_attr()`, `esc_url()`, `wp_kses_post()`.

```php
// Query example
$post_id = absint( $_POST['post_id'] );
$result  = $wpdb->get_row(
    $wpdb->prepare( "SELECT * FROM {$wpdb->posts} WHERE ID = %d", $post_id )
);

// Escaped output example
echo '<a href="' . esc_url( $result->guid ) . '">' . esc_html( $result->post_title ) . '</a>';
```

## 2. Hook Architecture & Modularity
- **Purity in Filters**: Filter callbacks must be pure functions that take input, transform it, and return the modified value without database or network side effects.
- **Actions for Side Effects**: Place state-changing operations and integrations inside action hooks (`init`, `wp_enqueue_scripts`, `save_post`).
- **Namespace & Prefixing**: Group code inside PHP namespaces (PHP 7.4+) or use strict vendor prefixes to prevent global namespace collisions.
- **Separation of Concerns**: Hook callbacks should remain small adapters (< 30 lines) delegating to testable service classes.

## 3. SiteGround Platform Constraints
- **Speed Optimizer (Caching)**:
  - SiteGround employs Dynamic Cache, Memcached, and file-based caching.
  - Template changes, REST API responses, and transient updates may be cached. When verifying code changes, purge the cache using WP-CLI (`wp sg purge` / `wp cache flush`) or programmatically via `sg_cachepress_purge_cache()`.
- **Security Optimizer**:
  - `DISALLOW_FILE_EDIT` is active by default. Never assume theme/plugin files can be modified via the WP Admin dashboard.
  - PHP execution inside `wp-content/uploads/` is strictly blocked by SiteGround server-level security rules.
- **WP-CLI & SSH Access**:
  - WP-CLI is pre-installed (`wp`).
  - SiteGround SSH runs on non-standard port `18765` using private key authentication.

## 4. Performance & Coding Standards
- **Transients**: Cache expensive external API responses or complex queries using `set_transient()` and `get_transient()`.
- **Autoloading Options**: Set `$autoload = 'no'` in `add_option()` / `update_option()` for large or rarely accessed configuration data to avoid bloat in `alloptions`.
- **Coding Standards**: Follow WordPress Coding Standards (WPCS / `phpcs`) for indentation (tabs), naming conventions (`snake_case`), and docblocks.
