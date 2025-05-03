
{{/*
Expand the name of the chart.
*/}}
{{- define "deploystack.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "deploystack.fullname" -}}
{{- if .Values.global.fullnameOverride }}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.global.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "deploystack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "deploystack.labels" -}}
helm.sh/chart: {{ include "deploystack.chart" . }}
{{ include "deploystack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "deploystack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploystack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service reference helper
*/}}
{{- define "deploystack.serviceReference" -}}
{{- if .service }}
{{- if .service.service.ports }}
{{- with index .service.service.ports 0 }}
{{ $.serviceKey }}.{{ $.serviceName }}.svc.cluster.local:{{ .port }}
{{- end }}
{{- else }}
{{ $.serviceKey }}.{{ $.serviceName }}.svc.cluster.local
{{- end }}
{{- else }}
unknown-service-reference
{{- end }}
{{- end }}
