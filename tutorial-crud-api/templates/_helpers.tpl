{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "tutorial-crud-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tutorial-crud-api.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tutorial-crud-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "tutorial-crud-api.labels" -}}
helm.sh/chart: {{ include "tutorial-crud-api.chart" . }}
{{ include "tutorial-crud-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Backend labels
*/}}
{{- define "tutorial-crud-api.labels.backend" -}}
app.component.type: backend
{{- end -}}

{{/*
Frontend labels
*/}}
{{- define "tutorial-crud-api.labels.frontend" -}}
app.component.type: frontend
{{- end -}}


{{/*
Selector labels
*/}}
{{- define "tutorial-crud-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tutorial-crud-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels - backend
*/}}
{{- define "tutorial-crud-api.selectorLabels.backend" -}}
app.component.type: backend
{{- end -}}

{{/*
Selector labels - frontend
*/}}
{{- define "tutorial-crud-api.selectorLabels.frontend" -}}
app.component.type: frontend
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "tutorial-crud-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "tutorial-crud-api.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
