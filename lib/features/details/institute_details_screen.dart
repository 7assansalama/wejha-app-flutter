*** Begin Patch
*** Update File: lib/features/details/institute_details_screen.dart
@@
-    String programsTabTitle = widget.institute.type == "U.O?OU?O? O?O_O?USO""
-        ? "OU,O_U^O?OO?"
-        : (widget.institute.type == "O?OU.O1OO?" ? "OU,U?U,USOO?" : "OU,U.O?OO-U,");
+    String programsTabTitle = widget.institute.type == "U.O?OU?O? O?O_O?USO""
+        ? "OU,O_U^O?OO?"
+        : (widget.institute.type == "O?OU.O1OO?" ? "OU,U?U,USOO?" : "OU,U.O?OO-U,");
@@
-                  color: AppColors.primary.withOpacity(0.1),
+                  color: AppColors.primary.withValues(alpha = 0.1),
@@
-                  widget.type == "U.O?OU?O? O?O_O?USO"" ? Icons.class_ : Icons.school,
+                  widget.institute.type == "U.O?OU?O? O?O_O?USO"" ? Icons.class_ : Icons.school,
@@
-                    widget.type == "U.O?OU?O? O?O_O?USO""
+                    widget.institute.type == "U.O?OU?O? O?O_O?USO""
                         ? "O_U^O?Oc OU,U,O?Oc OU,O?U+O?U,USO?USOc - U.O3O?U^U% "
                         : "OU,O?U? OU,O_O?OO3US ",
@@
-                    widget.type == "U.O?OU?O? O?O_O?USO""
+                    widget.institute.type == "U.O?OU?O? O?O_O?USO""
                         ? "30 O3OO1Oc O?O_O?USO"USOc"
                         : "OU,U.O?OO?USU?: 15,000 O?.O3",
*** End Patch
