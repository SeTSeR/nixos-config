;;; package --- Summary
;;; Commentary:
;;; DAP settings

;;; Code:

(use-package dap-mode
  :config
  (dap-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))

(use-package dap-gdb-lldb)

;;; dap.el ends here
