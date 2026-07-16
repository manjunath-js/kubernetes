{{- define "shopsphere.labels" -}}
app.kubernetes.io/part-of: shopsphere
app.kubernetes.io/managed-by: Helm
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "shopsphere.selectorLabels" -}}
app.kubernetes.io/part-of: shopsphere
{{- end -}}
