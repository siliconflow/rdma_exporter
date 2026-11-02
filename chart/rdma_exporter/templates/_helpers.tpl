{{/*
Expand the name of the chart.
*/}}
{{- define "rdma_exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | replace "_" "-" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "rdma_exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride | replace "_" "-" }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rdma_exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rdma_exporter.labels" -}}
helm.sh/chart: {{ include "rdma_exporter.chart" . }}
{{ include "rdma_exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rdma_exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rdma_exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rdma_exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rdma_exporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "rdma_exporter.serviceName" -}}
{{- default (include "rdma_exporter.fullname" .) .Values.service.name }}
{{- end }}

{{/*
Create the name of the ServiceMonitor to use
*/}}
{{- define "rdma_exporter.serviceMonitorName" -}}
{{- default (include "rdma_exporter.fullname" .) .Values.metrics.serviceMonitor.name }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "rdma_exporter.podAnnotations" -}}
{{- with .Values.podAnnotations }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Get the namespace
*/}}
{{- define "rdma_exporter.namespace" -}}
{{- if .Values.namespace }}
{{- .Values.namespace }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}
