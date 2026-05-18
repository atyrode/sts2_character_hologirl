export function IconButton({ id, icon: Icon, label, className = "", title = label, children, ...props }) {
  return (
    <button
      id={id}
      className={`icon-button ${className}`.trim()}
      title={title}
      aria-label={label}
      type="button"
      {...props}
    >
      <Icon aria-hidden="true" size={17} />
      {children ? <span>{children}</span> : null}
    </button>
  );
}
